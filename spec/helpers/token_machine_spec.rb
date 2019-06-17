require 'rails_helper'

RSpec.describe TokenMachine, type: :class do

  context '#constants' do
    let!(:token_lenght_expected) { 7 }
    let!(:token_alphabet_expected) { %w[0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z] }
    let!(:ambiguous_alphabet_expected) { %w[1 I L 5 S 0 O D 8 B U V W] }
    let!(:hash_equivalence_expected) { { "1" => %w[I L], "I" => %w[1 L], "L" => %w[1 I], "5" => %w[S], "S" => %w[5],
                                         "0" => %w[O D], "O" => %w[0 D], "D" => %w[0 O], "8" => %w[B], "B" => %w[8],
                                         "U" => %w[V W], "V" => %w[U W], "W" => %w[U V] } }

    it { expect(described_class::TOKEN_LENGTH).to eq token_lenght_expected }
    it { expect(described_class::TOKEN_ALPHABET).to eq token_alphabet_expected }
    it { expect(described_class::AMBIGUOUS_ALPHABET).to eq ambiguous_alphabet_expected }
    it { expect(described_class::HASH_EQUIVALENCE).to eq hash_equivalence_expected }
  end

  context '#generate_token' do
    it { expect(described_class.generate_token).to match /\A[A-Z0-9]{7}\z/ }
  end

  context '#conversion_token' do
    let!(:token) { 'O5FTX8I' }
    let!(:expected_tokens) { ["0SFTXB1", "0SFTXBL", "0SFTXBI", "0SFTX81", "0SFTX8L", "0SFTX8I", "05FTXB1", "05FTXBL",
                              "05FTXBI", "05FTX81", "05FTX8L", "05FTX8I", "DSFTXB1", "DSFTXBL", "DSFTXBI", "DSFTX81",
                              "DSFTX8L", "DSFTX8I", "D5FTXB1", "D5FTXBL", "D5FTXBI", "D5FTX81", "D5FTX8L", "D5FTX8I",
                              "OSFTXB1", "OSFTXBL", "OSFTXBI", "OSFTX81", "OSFTX8L", "OSFTX8I", "O5FTXB1", "O5FTXBL",
                              "O5FTXBI", "O5FTX81", "O5FTX8L", "O5FTX8I"] }

    it { expect(described_class.conversion_token(token)).to eq expected_tokens }
  end

  context '#nearby_tokens' do
    let!(:token) { 'O5FTX8I' }
    let!(:expected_tokens) { ['%5FTX8I', 'O%FTX8I', 'O5FTX%I', 'O5FTX8%'] }

    it { expect(described_class.nearby_tokens(token)).to eq expected_tokens }
  end
end
