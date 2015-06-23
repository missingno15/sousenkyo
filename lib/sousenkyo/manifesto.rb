module Sousenkyo
  class Manifesto
    attr_reader :filepath
    attr_accessor :list

    def initialize(args)
      @filepath = args.fetch(:manifesto_path, Sousenkyo.config_path("manifesto.yml"))
      load_manifesto
    end

    def add(member)
      unless already_exists?(member) 
        list << member
        save!
      end
    end

    def edit(member)
      list.map! do |existing_member|
        if existing_member.jpname == member.jpname
          existing_member.tap do |em|
            em.attributes = member.attributes
          end
        else
          existing_member
        end
      end

      save!
    end

    def delete(member)
      list.delete_if do |existing_member| 
        existing_member.jpname == member.jpname
      end

      save!
    end

    private

    attr_reader :filepath, :roster_path

    def load_manifesto
      if File.exists?(filepath)
        @list = YAML.load_file(filepath).map { |member| Member.new(member) }
      else
        @list = []
      end
    end

    def already_exists?(member)
      list.any? do |existing_member| 
        existing_member.jpname == member.jpname
      end
    end

    def list_to_hash
      list.empty? ? list : list.map(&:attributes)
    end

    def save!
      File.write(filepath, list_to_hash.to_yaml)
    end
  end
end
