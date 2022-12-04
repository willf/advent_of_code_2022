module AllenAlgebra
  def precedes?(other)
    self.end < other.begin
  end

  def meets?(other)
    self.end == other.begin
  end

  def overlaps?(other)
    self.end > other.begin && self.end < other.end
  end

  def finished_by?(other)
    self.end == other.end && self.begin < other.begin
  end

  def contains?(other)
    self.begin < other.begin && self.end > other.end
  end

  def begins?(other)
    self.begin == other.begin && self.end < other.end
  end

  def equals?(other)
    self.begin == other.begin && self.end == other.end
  end

  def begined_by?(other)
    self.begin == other.begin && self.end > other.end
  end

  def during?(other)
    self.begin > other.begin && self.end < other.end
  end

  def finishes?(other)
    self.begin > other.begin && self.end == other.end
  end

  def overlapped_by?(other)
    self.begin < other.begin && self.end > other.begin && self.end < other.end
  end

  def met_by?(other)
    self.begin == other.end
  end

  def preceded_by?(other)
    self.begin > other.end
  end

  def commpletely_includes?(other)
    self.begin <= other.begin && self.end >= other.end
  end

  def overlaps_at_all?(other)
    !self.precedes?(other) && !self.preceded_by?(other)
  end
end
