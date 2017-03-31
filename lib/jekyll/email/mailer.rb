module Jekyll
  module Email
    class Mailer
      def initialize
        options = { address:             'smtp.gmail.com',
                    port:                 587,
                    domain:               'gmail.com',
                    user_name:            ENV['GMAIL_NAME'],
                    password:             ENV['GMAIL_PASSWORD'],
                    authentication:       'plain',
                    enable_starttls_auto: true
        }

        Mail.defaults do
          delivery_method :smtp, options
        end
      end

      def deliver(to, subject, body)
        Mail.deliver do
          from    ENV['GMAIL_NAME']
          to      to
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
