class String

  LATEX_SPECIAL_CHAR = /[\\{}$&\n#^_%~]/

  def to_latex!
    return self if latex?

    gsub!(LATEX_SPECIAL_CHAR) do |c|
      case c
      when "\\" then '\backslash'
      when "^" then '\char94'
      when '~' then '\char126'
      else "\\#{c}"
      end
    end

    self.latex!
  end


  def to_latex
    return self if latex?

    dup.to_latex!
  end

  def to_latex_math
    "$#{to_latex}$"
  end


  def latex?
    defined?(@is_latex) && @is_latex
  end

  def latex!
    @is_latex = true
    self
  end

end



class Object
  def to_latex
    to_s.to_latex!
  end

  def to_latex_math
    "$#{to_latex}$".latex!
  end
end
