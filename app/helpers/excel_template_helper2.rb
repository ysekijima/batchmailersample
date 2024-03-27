# app/helpers/excel_template_helper.rb
module ExcelTemplateHelper2
  require 'rubyXL/convenience_methods' # <===最新のrubyXLだと必要
  def excel_render2(template_file)
    RubyXL::Parser.parse(template_file).tap do |workbook|
      workbook.worksheets.each do |worksheet|
        @worksheet = worksheet
        @worksheet.each_with_index do |row, row_num|
          row&.cells&.each do |cell|
            next if cell.nil?
            cell_render(cell)
          end
          row_height_auto(row_num)
        end
      end
    end
  end

  private

  def content_eval(content)
    view_context.instance_eval(%("#{content}")).gsub(/\R/, "\n") # エクセルの改行は LF
  end

	# ここはおまけの方で上書きするので削除
  # def cell_render(cell)
  #   cell.change_contents(content_eval(cell.value))
  #   cell.change_text_wrap(true) if (cell&.value&.lines("\n")&.count) > 1
  # rescue
  #   cell.change_contents('error!')
  #   cell.change_font_color('FF0000')
  #   cell.change_fill('FFFF00')
  # end

  def row_height_auto(row_num)
    max_lines = @worksheet[row_num]&.cells&.map { |cell| cell&.value&.lines("\n")&.count || 0 }&.max
    origin_height = [@worksheet.get_row_height(row_num), 20].max # 最小値が RubyXL::Row::DEFAULT_HEIGHT (= 13) では合わなかったので手動調整
    @worksheet.change_row_height(row_num, origin_height * max_lines) if max_lines&.positive?
  end

  # 以下おまけ部
  def spread_render(cell, array_name)
    original_style_index = cell.style_index
    original_row_height = @worksheet.get_row_height(cell.row)
    view_context.instance_eval(array_name).each_with_index do |_array, index|
      target_row = cell.row + index
      target_column = cell.column
      target_value = cell.value.gsub("#{array_name}[]") { "#{array_name}[#{index}]" } # 配列変数部に添え字を付与する
      @worksheet.add_cell(target_row, target_column, content_eval(target_value))
      @worksheet[target_row][target_column].style_index = original_style_index
      @worksheet.change_row_height(target_row, original_row_height)
    end
  end

  def normal_render(cell)
    cell.change_contents(content_eval(cell.value))
    cell.change_text_wrap(true) if (cell&.value&.lines("\n")&.count) > 1
  end

  def cell_render(cell)
    # if /(?<array_name>@[\w-]+)\[:[\w-]*\]/ =~ cell.value
    if /(?<array_name>@[\w-]+)\[\]/ =~ cell.value
      spread_render(cell, array_name) # 配列変数を展開しながらのレンダリング
    else
      normal_render(cell) # 通常のレンダリング
    end
  rescue StandardError
    cell.change_contents('error!')
    cell.change_font_color('FF0000')
    cell.change_fill('FFFF00')
  end

end
