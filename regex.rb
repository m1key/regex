class Extractor
  attr_reader :params, :things, :numbers
  def initialize(string)
    @string = string
    extract_params
    extract_things
    extract_numbers
  end

  private def extract_params
   @params = @string.to_enum(:scan, /<(.*?)>/).map { $1 }
  end

  private def extract_things
    @things = @string.to_enum(:scan, /"(.*?)"/).map { $1 }
  end

  private def extract_numbers
    numbers_not_within_params = @string.to_enum(:scan, /(\d+)(?![^<]*>)/).map { $1 }
    numbers_not_within_things = @string.to_enum(:scan, /(\d+)(?=([^"]*"[^"]*"[^"]*|[^"]*)*$)/).map { $1 }
    @numbers = numbers_not_within_params & numbers_not_within_things
  end

end
