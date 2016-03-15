module GermanHelper
  def nom base_article, word
    case_tag 'nom', base_article, base_article, word
  end

  def akk base_article, word
    mapping = {
      'der' => 'den'
    }
    article = mapping[base_article] || base_article
    case_tag 'akk', base_article, article, word
  end

  def dat base_article, word
    mapping = {
      'der' => 'dem',
      'die' => 'der',
      'das' => 'dem',
      'die plural' => 'den',
    }
    article = mapping[base_article] || base_article
    case_tag 'dat', base_article, article, word
  end

  private

  def case_tag type, base_article, article, word
    if base_article == article
      "<span class='case #{type}'>#{article} #{word}</span>"
    else
      "<span class='case #{type}'><abbr title='#{type}: #{base_article} &rarr; #{article}'>#{article}</abbr> #{word}</span>"
    end
  end
end
