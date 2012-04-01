require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ToLatex" do
  specify "String#to_latex" do
    '%'.to_latex.should == '\%'
    '!'.to_latex.should == '!'
    '^'.to_latex.should == '\^{}'
    'a'.to_latex.should == 'a'

    'a'.should_not be_latex
    'a'.to_latex.should be_latex

    a = 'a'
    a.should_not be_latex
    a.to_latex.should_not be_equal a
    a.to_latex.should be_latex
  end

  specify "String#latex!" do
    '%'.latex!.should == '%'
    '!'.latex!.should == '!'
    '^'.latex!.should == '^'
    'a'.latex!.should == 'a'

    'a'.latex!.should be_latex

    a = 'a'
    a.should_not be_latex
    a.latex!.should_not be_equal a
    a.latex!.should be_latex

    b = a.to_latex
    b.latex!.should be_equal b
  end

  specify "String#latex! is not destructive" do
    "a%!\\#".freeze.latex!
  end

  specify "String#to_latex is not destructive" do
    "a%!\\#".freeze.to_latex
  end



  specify "Integer" do
    5.to_latex.should == "5"
  end

  specify "to_latex_math" do
    def check_to_latex_math source, result
      source.to_latex_math.should == result
      source.to_s.to_latex_math.should == result
      source.to_s.to_latex.to_latex_math.should == result
      source.to_s.to_latex.to_latex_math.to_latex.should == result
    end

    check_to_latex_math 5, "\\ensuremath{5}"
    check_to_latex_math "a", "\\ensuremath{a}"
    check_to_latex_math "5%", "\\ensuremath{5\\%}"

    "5%".to_latex_math("\\[").should == "\\[5\\%\\]"
    "5%".to_latex_math("\\(").should == "\\(5\\%\\)"
    "5%".to_latex_math("$").should == "$5\\%$"
    "5%".to_latex_math("$$").should == "$$5\\%$$"
    "5%".to_latex_math("a").should == "a5\\%a"
    "5%".to_latex_math("a","b").should == "a5\\%b"
    "5%".to_latex_math("$","$").should == "$5\\%$"
  end

  specify "dup" do
    "a".dup.should_not be_latex
    "a".to_latex.dup.should be_latex
    "a".to_latex.dup.should == "a"
  end

  specify "concat" do
    ("a" + "#").should == "a#"
    ("a".concat "#").should == "a#"
    ("a" << "#").should == "a#"
    ("a".to_latex + "#").should == "a\\#"
    ("a".to_latex.concat "#").should == "a\\#"
    ("a".to_latex << "#").should == "a\\#"
    ("a".to_latex + "#".to_latex).should == "a\\#"
    ("a".to_latex.concat "#".to_latex).should == "a\\#"
    ("a".to_latex << "#".to_latex).should == "a\\#"
    ["a\\".to_latex]
  end

  specify "to_s[tr]" do
    a="a".to_latex
    a.to_s.should == "a"
    a.to_s.should be_latex
    a.to_str.should == "a"
    a.to_str.should_not be_latex
  end
  

end
