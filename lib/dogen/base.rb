require 'rendering_engine'
require 'awesome_print'

module Dogen
  class Base
    def set_repository(args)
      source, place = args.first.to_s.split('::')

      if source.downcase == 'path'
        raise "Missing path: #{place}" unless File.directory?(place)
        configuration.set(repository: { source: 'path', place: place })
      else
        raise "Unknown source #{source}"
      end
    end

    def parse_opts(args)
      Hash[(args.map { |item| item.split(':') })]
    end

    def read_opts_from_json(path)
      raise 'File not found' unless File.exist?(path)
      JSON.parse(IO.read(path))
    end

    def generate(path, opts = {})
      new_file_path = File.join(current_dir, File.basename(path))
      File.write(new_file_path, provider.get(path, data: opts).source)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    private

    def current_dir
      Dir.pwd
    end

    def provider
      @provider ||= RenderingEngine::Provider.new(file_repo)
    end

    def file_repo
      @file_repo ||= RenderingEngine::FileRepo.new(base_path)
    end

    def base_path
      @base_path ||= configuration.get.fetch(:repository).fetch(:place)
    rescue
      raise 'Repository configuration error. Check your configuration.'
    end
  end
end
