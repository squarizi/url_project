class TokenMachine
  TOKEN_LENGTH = 7
  TOKEN_ALPHABET = %w[0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]
  AMBIGUOUS_ALPHABET = %w[1 I L 5 S 0 O D 8 B U V W]
  HASH_EQUIVALENCE = {
                       "1" => %w[I L], "I" => %w[1 L], "L" => %w[1 I], "5" => %w[S], "S" => %w[5],
                       "0" => %w[O D], "O" => %w[0 D], "D" => %w[0 O], "8" => %w[B], "B" => %w[8],
                       "U" => %w[V W], "V" => %w[U W], "W" => %w[U V]
                     }

  def self.generate_token
    (0...TOKEN_LENGTH).map { TOKEN_ALPHABET[rand(TOKEN_ALPHABET.size)] }.join
  end

  def self.conversion_token(token)
    @token = token
    @control_array = Array.new(1)
    @final_array = []

    organize_chars
    final_tokens
  end

  def self.nearby_tokens(nearby_token)
    @nearby_token = nearby_token

    prepared_tokens
  end

  private

  def self.prepared_tokens
    ambiguous_index_chars.map do |array_index|
      preparing_token(array_index)
    end
  end

  def self.ambiguous_index_chars
    @nearby_token.chars.map.with_index { |char, index| index if AMBIGUOUS_ALPHABET.include?(char) }.compact
  end

  def self.preparing_token(array_index)
    @nearby_token.chars.map.with_index { |char, index| index == array_index ? '%' : char }.join
  end

  def self.organize_chars
    @token.chars.each do |char|
      @char_params = AMBIGUOUS_ALPHABET.include?(char) ? [HASH_EQUIVALENCE[char], char].flatten : [char]

      build_tokens
    end
  end

  def self.build_tokens
    @control_array.each do |token|
      populate_final_array(token)
    end

    update_control_array
  end

  def self.populate_final_array(token)
    @char_params.each { |char| @final_array.push("#{token}#{char}") }
  end

  def self.update_control_array
    @final_array.each { |item| @control_array.push(item) }
  end

  def self.final_tokens
    @final_array.reject { |item| item.size < TOKEN_LENGTH }
  end
end
