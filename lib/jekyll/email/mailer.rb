module Jekyll
  module Email
    class Mailer
      OPTIONS = { address:             'smtp.gmail.com',
                  port:                 587,
                  domain:               'gmail.com',
                  user_name:            ENV['GMAIL_LOGIN'],
                  password:             ENV['GMAIL_PASSWORD'],
                  authentication:       'plain',
                  enable_starttls_auto: true
                }
      def initialize(smtp = true)
        delivery = smtp ? :smtp : LetterOpener::DeliveryMethod
        options = smtp ? OPTIONS : { location: File.expand_path('../tmp/letter_opener', __FILE__) }

        Mail.defaults do
          delivery_method delivery, options
        end
      end

      def deliver(to, subject, body)
        Mail.deliver do
          from    ENV['GMAIL_LOGIN']
          bcc     to
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
