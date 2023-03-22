# frozen_string_literal: true

RSpec.describe RKTheory do
  it 'has a version number' do
    expect(RKTheory::VERSION).not_to be nil
  end

  it 'implements a logger' do
    expect { RKTheory.logger }.not_to raise_error
  end

  it 'sets the log level to warning' do
    expect(RKTheory.logger.level).to eq(Logger::WARN)
  end
end
