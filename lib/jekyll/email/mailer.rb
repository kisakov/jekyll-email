module Jekyll
  module Email
    class Mailer
      attr_reader :is_smtp

      OPTIONS = { address:             'smtp.gmail.com',
                  port:                 587,
                  domain:               'gmail.com',
                  user_name:            ENV['GMAIL_LOGIN'],
                  password:             ENV['GMAIL_PASSWORD'],
                  authentication:       'plain',
                  enable_starttls_auto: true
                }

      def initialize(smtp = true)
        @is_smtp = smtp
        delivery = smtp ? :smtp : LetterOpener::DeliveryMethod
        options = smtp ? OPTIONS : { location: File.expand_path('../tmp/letter_opener', __FILE__) }

        Mail.defaults do
          delivery_method delivery, options
        end
      end

      def deliver(recipients, subject, body)
        recipients_list = recipients.split(',').map(&:strip)
        recipients_list = [recipients_list.first] unless is_smtp

        recipients_list.each do |recipient|
          puts "sending to #{recipient}..."
          deliver_to_recipient(recipient, subject, body)
        end
      end

      private

      def deliver_to_recipient(recipient, subject, body)
        Mail.deliver do
          from    ENV['GMAIL_LOGIN']
          to      recipient
          subject subject

          html_part do
            content_type 'text/html; charset=UTF-8'
            body body
          end
        end
      end
    end
  end
end
