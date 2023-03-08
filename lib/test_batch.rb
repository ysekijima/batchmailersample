require 'base_batch'

class TestBatch < BaseBatch
  def main
    @multi_logger.debug 'this is debug message'
    # do anything
    up_fee
  end

  private
    def up_fee
      ActiveRecord::Base.transaction do
        Staff.order(:name).each do |s|
          if s.fee >= 1000
            mail_texts_add("#{s.name}さんのお給料は#{s.fee}円のまま据え置きでした。")
            next
          else
            s.fee += 100
            mail_texts_add("#{s.name}さんのお給料が#{s.fee}円にあがりました！")
            s.save!
          end
        end
      end
    end
end
