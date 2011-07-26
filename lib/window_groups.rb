class WindowGroups
  include Enumerable

  def initialize
    @groups = []
  end

  def <<(advert)
    return unless advert.window?

    group = @groups.find {|group| group.starts_at == advert.starts_at}
    if group
      @groups.delete(group)
    else
      group = WindowGroup.new
      group.starts_at = advert.starts_at
      group.expires_at = advert.expires_at
    end

    group.total += 1
    group.number_in_use += 1 if advert.property

    @groups << group
  end

  def each &block
    @groups.each{|group| block.call(group)}
  end
end
