module Sousenkyo
  class Manifesto
    MANIFESTO_PATH = Sousenkyo.config_path("manifesto.yml")

    attr_accessor :db

    def initialize
      @db = load_manifesto 
      @roster = load_roster
    end

    def add(member)
      db[member.name.to_sym] = member.vote_count
      write(db)
    end

    def edit(member)
      db[search_for(member)] = member.vote_count
      write(db)
    rescue MemberNotFound
      puts "Couldn't find member with name of #{member.name}"
    end

    def delete(member)
      key = search_for(member)
      response = confirm_delete(key)

      until response == "y" || response || == "n"
        response = confirm_delete(key)
      end

      if response == "y"
        db.delete(key)
        write(db)
      elsif response == "n"
        exit 0
      end
    rescue MemberNotFound
    end

    def list
      db.each do |member, vote_count|
        puts "#{member}".rjust()
      end
    end

    def filepath
      MANIFESTO_PATH
    end

    private

    def load_manifesto
      if File.exists?(MANIFESTO_PATH)
        YAML.load_file(MANIFESTO_PATH)
      else
        {}
      end
    end

    def load_roster
      YAML.load_file(File.join(Sousenkyo.root, "config", "roster2015.yml")) 
    end

    def write(obj)
      File.write(MANIFESTO_PATH, obj.to_yaml)
    end

    def search_for(member)
      key = db.keys.find { |name| name == member.name.to_sym }

      if key
        key
      else
        raise MemberNotFound 
      end
    end

    def confirm_delete(name)
      puts "Are you sure you want to delete #{name.to_s}? (y/n)"
      response = gets.chomp
    end
  end
end
