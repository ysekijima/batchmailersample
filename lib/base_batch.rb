class BaseBatch

  def initialize(name, args = nil)
    @name = name
    @args = args
    @mail_texts = []
    @multi_logger = multi_logger
  end

  def mail_texts_add(added_text)
    @mail_texts << added_text if added_text
  end

  # ログ出力をファイルとコンソールの両方に行う
  def multi_logger
    dir = File.dirname("log/#{@name}.log")
    FileUtils.mkdir_p(dir) unless File.directory?(dir)
    logger = ActiveSupport::Logger.new("log/#{@name}.log")
    logger.formatter = Logger::Formatter.new
    logger.datetime_format = '%Y-%m-%d %H:%M:%S'

    srdout_logger = ActiveSupport::Logger.new(STDOUT)
    multiple_loggers = ActiveSupport::Logger.broadcast(srdout_logger)
    logger.extend(multiple_loggers)

    logger
  end

  def run
    start_time = Time.zone.now
    @multi_logger.info "START #{@name}  - #{start_time.strftime('%Y-%m-%d %H:%M:%S')}"

    begin
      main # 実行
    rescue StandardError => e
      @multi_logger.error "=====error!!!===="
      @multi_logger.error e
      mail_texts_add "---エラー情報---"
      mail_texts_add "#{e.class} が発生しました。"
      mail_texts_add e.message
      # 失敗メール送信
      BatchNotiferMailer.with(batch_name: @name, response_texts: @mail_texts).result_failed.deliver_now
    else
      @multi_logger.info "#{@name}が成功しました。"
      # 成功メール送信
      BatchNotiferMailer.with(batch_name: @name, response_texts: @mail_texts).result_successful.deliver_now
    end
    @multi_logger.info "End #{@name} - runtime[#{Time.zone.now - start_time}]"
  end
end
