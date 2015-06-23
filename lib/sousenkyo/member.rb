module Sousenkyo
  class Member
    ROSTER = YAML.load_file(Sousenkyo.config_path("roster2015.yml"))

    attr_reader :engname,
                :group,
                :jpname,
                :jpname_with_space,
                :successful_vote_count,
                :team
    attr_accessor :vote_count

    def self.all
      ROSTER.map { |member| self.new(member) }
    end

    def self.where(attrs)
      attrs_array = attrs.to_a
      ROSTER.select do |member_attrs|
        attrs_array.all? do |kv_pair|
          k,v = kv_pair
          member_attrs[k] == v
        end
      end.map { |member| self.new(member) }
    end

    def self.find_by(attrs)
      attrs_array = attrs.to_a
      member = ROSTER.find do |member_attrs|
        attrs_array.all? do |kv_pair|
          k,v = kv_pair
          member_attrs[k] == v
        end
      end

      self.new(member) if member
    end

    def initialize(args)
      @group = args[:group]
      @team = args[:team]
      @jpname = args[:jpname]
      @jpname_with_space = args[:jpname_with_space]
      @engname = args[:engname]
      @vote_count = args.fetch(:vote_count, 0)
      @successful_vote_count = args.fetch(:successful_vote_count, 0)
    end

    def attributes=(attrs)
      if attrs.class == Hash
        attrs.each do |k, v|
          if instance_variable_defined?("@#{k}")
            instance_variable_set("@#{k}", v)
          end
        end
      end
    end

    def attributes
      {
        group: group,
        team: team,
        jpname: jpname,
        jpname_with_space: jpname_with_space,
        engname: engname,
        vote_count: vote_count,
        successful_vote_count: successful_vote_count
      }
    end

    def increment_successful_vote_count!
      @successful_vote_count += 1
    end

    def name
      Sousenkyo.locale == :en ? engname : jpname
    end

    def remaining_vote_count
      vote_count - successful_vote_count
    end
  end
end
