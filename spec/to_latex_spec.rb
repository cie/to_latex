require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ToLatex" do
  specify "String" do
    '%'.to_latex.should == '\%'
    '!'.to_latex.should == '!'
    '^'.to_latex.should == '\char94'
    'a'.to_latex.should == 'a'

    'a'.should_not be_latex
    'a'.to_latex.should be_latex

    a = 'a'
    a.should_not be_latex
    a.to_latex!.should be_equal a
    a.should be_latex

  end

  specify "Integer" do

  end

end
