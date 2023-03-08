class BatchNotiferMailer < ApplicationMailer
  def result_failed
    subject = "#{params[:batch_name]} 実行結果のお知らせ（失敗にゃん）"
    mail_batch_result(subject)
  end

  def result_successful
    subject = "#{params[:batch_name]} 実行結果のお知らせ（成功にゃん）"
    mail_batch_result(subject)
  end

  def mail_batch_result(subject)
    env_str = "【#{ENV['RAILS_ENV'] || 'development'}】"
    @response_texts = params[:response_texts].to_a
    @batch_name = "#{env_str} #{params[:batch_name]}"

    mail(
      to: 'pyayo200@hamham.uk',
      subject: "#{env_str}#{subject}"
    )
  end
end
