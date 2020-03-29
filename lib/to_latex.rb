module ToLatex
  LATEX_SPECIAL_CHAR = /[\\{}$&#^_%~]/

  DELIMITER_PAIRS = { 
    "$" => "$",
    "$$" => "$$",
    "\\(" => "\\)",
    "\\[" => "\\]",
    "\\ensuremath{" => "}"
  }

  def self.escape s
    s.gsub(LATEX_SPECIAL_CHAR) do |c|
      case c
      when "\\" then '\textbackslash{}'
      when "^" then '\^{}'
      when '~' then '\~{}'
      else "\\#{c}"
      end
    end
  end

  # A string converted to latex
  class LatexString < String
    def to_latex
      self
    end

    def latex!
      self
    end

    def latex?
      true
    end

    def concat value
      if value.latex?
        super value
      else
        super value.to_latex
      end
    end
    
    alias << concat

    def +(other)
      dup.concat(other)
    end

    def to_s
      self
    end
  end

end

class String
  # Convert a string to latex with escaping special characters.
  def to_latex
    ToLatex::LatexString.new ToLatex.escape(self)
  end

  # Convert a string to latex without escaping. Despite the bang, this is NOT
  # destructive, it returns a new object.
  def latex!
    ToLatex::LatexString.new self
  end

  # Tells if this is a string converted to latex
  def latex?
    false
  end
end



module ToLatex::Convertible
  # Convert an object to latex with escaping
  def to_latex
    to_s.to_latex
  end

  # Convert an object to latex with escaping and adding \ensuremath{}, $$ or other delimiter around
  def to_latex_math open = "\\ensuremath{", close = nil
    close ||= ToLatex::DELIMITER_PAIRS[open] || open
    ToLatex::LatexString.new "#{open}#{to_latex}#{close}"
  end
end

[Integer, String].each do |c|
  c.send :include, ToLatex::Convertible
end 

