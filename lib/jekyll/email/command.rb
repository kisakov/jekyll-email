module Jekyll
  module Email
    class Command < Jekyll::Command
      class << self
        def init_with_program(prog)
          prog.command(:mail) do |c|
            c.syntax "mail [options]"
            c.description 'Send email about psot'
            c.option 'post', '-post POST', 'Post name'
            c.option 'test', '-t', '--test', 'Test mode'

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
              if post
                data = post.data
                title = "#{options['mail_subject']} \"#{data['title']}\""
                body = options['mail_intro'] + "<br><br>" +
                       "<a href='#{options['domain']}#{post.url}'>\"#{data['title']}\"</a>" + "<br>" +
                       data['excerpt'].to_s.strip +
                       "<a href='#{options['domain']}#{post.url}'>#{options['mail_read_more']}</a>" + "<br><br>" +
                       options['mail_closing']
                Mailer.new(!opts['test']).deliver(ENV['RECIPIENTS'], title, body)

                puts "\nPost \"#{title}\" was sent to #{ENV['RECIPIENTS']}"
              else
                puts "\nError! Can't find post with this name.\n"
              end
            end
          end
        end
      end
    end
  end
end
