module Jekyll
  module Email
    class Command < Jekyll::Command
      class << self
        def init_with_program(prog)
          prog.command(:mail) do |c|
            c.syntax "mail [options]"
            c.description 'Send email about psot'
            c.option 'post', '-post POST', 'Post name'

            c.action do |args, opts|
              opts['post'] ||= args.first
              opts['serving'] = false
              Jekyll.logger.adjust_verbosity(opts)
              options = configuration_from_options(opts)
              site = Jekyll::Site.new(options)
              site.reset
              site.read
              posts = site.posts.docs
              post = opts['post'] ? posts.find { |post| post.basename.include?(opts['post']) } : posts.last
              data = post.data
              title = data['title']
              body = data['excerpt'].to_s.strip +
                     " <a href='#{options['domain']}#{post.url}'>#{options['email_more']}</a>"
              Mailer.new.deliver(options['emails'], title, body)

              puts "\nPost \"#{title}\" was sent to #{options['emails'].join(', ')}"
            end
          end
        end
      end
    end
  end
end
