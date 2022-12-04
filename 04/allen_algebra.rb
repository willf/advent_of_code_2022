module AllenAlgebra
  def precedes?(other)
    self.end < other.first
  end

  def meets?(other)
    self.end == other.first
  end

  def overlaps?(other)
    self.end > other.first && self.end < other.end
  end

  def finished_by?(other)
    self.end == other.end && self.first < other.first
  end

  def contains?(other)
    self.first < other.first && self.end > other.end
  end

  def firsts?(other)
    self.first == other.first && self.end < other.end
  end

  def equals?(other)
    self.first == other.first && self.end == other.end
  end

  def firsted_by?(other)
    self.first == other.first && self.end > other.end
  end

  def during?(other)
    self.first > other.first && self.end < other.end
  end

  def finishes?(other)
    self.first > other.first && self.end == other.end
  end

  def overlapped_by?(other)
    self.first < other.first && self.end > other.first && self.end < other.end
  end

  def met_by?(other)
    self.first == other.end
  end

  def preceded_by?(other)
    self.first > other.end
  end

  def commpletely_includes?(other)
    self.first <= other.first && self.end >= other.end
  end

  def overlaps_at_all?(other)
    !self.precedes?(other) && !self.preceded_by?(other)
  end
end
