require 'spec_helper'

describe Dogen::Configuration do
  let(:file_name)        { '.dogenrc' }
  let(:home_path)        { '/home/user' }
  let(:config_file_path) { "#{home_path}/#{file_name}" }
  subject { described_class.new }

  it 'CONFIG_FILE_NAME' do
    expect(described_class::CONFIG_FILE_NAME).to eq file_name
  end

  context '#get' do
    let(:config_hash) { { test: 1 } }
    before do
      expect(Dir).to receive(:home)
                     .at_least(1).times
                     .and_return(home_path)
    end

    it 'returns empty Hash when config file missing' do
      expect(File).to receive(:exist?).with(config_file_path).and_return(false)
      expect(subject.get).to eq Hash.new
    end

    it ' returns configuration as Hash when config file is present' do
      expect(File).to receive(:exist?).with(config_file_path).and_return(true)
      expect(YAML).to receive(:load_file)
                      .with(config_file_path)
                      .and_return(config_hash)
      expect(subject.get).to eq Hashie::Mash.new(config_hash)
    end
  end

  context '#set' do
    it 'raise SetConfigError when argument is not kind of Hash' do
      expect { subject.set('try') }.to raise_error
    end

    let(:config)           { Hashie::Mash.new(test: 1) }
    let(:config_to_update) { { test: 2, new_one: 1 } }
    let(:congig_yml)       { Hashie::Mash.new(config_to_update).to_yaml }

    it 'update configuration by merge hashies' do
      expect(Dir).to receive(:home).and_return(home_path)
      expect(subject).to receive(:get).and_return(config)
      expect(File).to receive(:write).with(config_file_path, congig_yml)
      subject.set(config_to_update)
    end
  end

  it '#clear' do
    expect(Dir).to receive(:home).and_return(home_path)
    expect(File).to receive(:write).with(config_file_path, {}.to_yaml)
    subject.clear
  end
end
