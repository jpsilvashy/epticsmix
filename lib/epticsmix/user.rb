module EpticsMix
  class User < ActiveRecord::Base

    def client
      @client ||= Client.new(self.username, self.password)
    end

    def season_stats(year = current_season)
      @season_stats ||= begin
        stats = client.season_stats
        return {} if stats.nil?

        stats.detect {|season| season['year'] == year.to_i } || {}
      end
    end

    def vertical_feet
      @vertical_feet ||= season_stats['verticalFeet'] || 0
    end

    def points
      @points ||= season_stats['points'] || 0
    end

    def current_season
      Time.now.month >= 5 ? Time.now.year : Time.now.year + 1
    end
  end
end
