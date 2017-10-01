class Noun
  def initialize gender, word, c = :nom
    @gender = gender
    @word = word
    @original_case = c
    @case = c
  end

  def to_s
    "#{definite_article} #{@word} (#{@original_case} &rarr; #{@case})"
  end

  def as c
    @case = c
    self
  end

  def definite_article
    {
      mask: { nom: 'der', akk: 'den', dat: 'dem' },
      fem:  { nom: 'die', akk: 'die', dat: 'der' },
      neu:  { nom: 'das', akk: 'das', dat: 'dem' },
      pl:   { nom: 'die', akk: 'die', dat: 'den' }
    }[@gender][@case]
  end

  def indefinite_article
    {
      mask: { n: 'ein',  a: 'einen', d: 'einem' },
      fem:  { n: 'eine', a: 'eine',  d: 'einer' },
      neu:  { n: 'ein',  a: 'ein',   d: 'einem' }
    }[@gender][@case]
  end
end

class Word
  def initialize gender, word
    @gender = gender
    @word = word
  end

  def definite_article
    DefiniteArticle.for(self, :n)
  end

  def gender
    @gender
  end

  def word
    @word
  end
end

class DefiniteArticle
  def self.for w, c
    rules = {
      m:  { n: 'der', a: 'den', d: 'dem' },
      f:  { n: 'die', a: 'die', d: 'der' },
      n:  { n: 'das', a: 'das', d: 'dem' },
      pl: { n: 'die', a: 'die', d: 'den' }
    }
    rules[w.gender][c]
  end
end

class IndefiniteArticle
  def self.for w, c
    rules = {
      m: { n: 'ein',  a: 'einen', d: 'einem' },
      f: { n: 'eine', a: 'eine',  d: 'einer' },
      n: { n: 'ein',  a: 'ein',   d: 'einem' }
    }
    rules[w.gender][c]
  end
end

class WordDisplay
  def initialize prefix, w, c
    @prefix = prefix
    @word = w
    @case = c
  end

  def to_s
    if @prefix == @word.definite_article
      "<span class='case case-#{@case}'>#{@prefix} #{@word.word}</span>"
    else
      "<span class='case case-#{@case}'><abbr title='#{@word.definite_article} &rarr; #{@prefix}'>#{@prefix}</abbr> #{@word.word}</span>"
    end
  end
end

module GermanHelper
  def definite_article w, c
    prefix = DefiniteArticle.for(w, c)
    WordDisplay.new(prefix, w, c)
  end

  def indefinite_article w, c
    prefix = IndefiniteArticle.for(w, c)
    WordDisplay.new(prefix, w, c)
  end

  def hi text
    "<span class='highlight'>#{text}</span>"
  end

  def quiet text
    "<span class='quiet'>#{text}</span>"
  end

  def nom text
    "<span class='case case-n'>#{text}</span>"
  end

  def akk text
    "<span class='case case-a'>#{text}</span>"
  end

  def dat text
    "<span class='case case-d'>#{text}</span>"
  end

  def abbr text, description
    "<abbr title='#{description}'>#{text}</abbr>"
  end

  def der word
    Word.new(:m, word)
  end

  def die word
    Word.new(:f, word)
  end

  def das word
    Word.new(:n, word)
  end

  def pl word
    Word.new(:pl, word)
  end
end
