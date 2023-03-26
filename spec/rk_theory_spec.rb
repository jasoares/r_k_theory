# frozen_string_literal: true

RSpec.describe RKTheory do
  it 'has a version number' do
    expect(described_class::VERSION).not_to be_nil
  end

  it 'implements a logger' do
    expect { described_class.logger }.not_to raise_error
  end

  it 'sets the log level to warning' do
    expect(described_class.logger.level).to eq(Logger::DEBUG)
  end
end
