module Jekyll
  module Email
    class Command < Jekyll::Command
      class << self
        def init_with_program(prog)
          prog.command(:mail) do |c|
            c.action do |args, opts|
              opts["serving"] = false
              Jekyll.logger.adjust_verbosity(opts)
              options = configuration_from_options(opts)
              site = Jekyll::Site.new(options)
              site.reset
              site.read
              data = site.posts.docs.last.data

              Mailer.new.deliver(options['emails'], data['title'], data['excerpt'].to_s.strip)
            end
          end
        end
      end
    end
  end
end
