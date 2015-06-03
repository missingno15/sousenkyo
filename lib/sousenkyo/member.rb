module Sousenkyo
  class Member
    ROSTER = YAML.load_file(Sousenkyo.config_path("roster2015.yml"))

    attr_reader :group, :team, :jpname, :jpname_with_space, :engname
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
      @vote_count = args[:vote_count]
    end

    def attributes
      {
        group: group,
        team: team,
        jpname: jpname,
        jpname_with_space: jpname_with_space,
        engname: engname,
        vote_count: vote_count
      }
    end
  end
end
