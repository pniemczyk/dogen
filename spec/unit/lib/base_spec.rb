require 'spec_helper'

describe Dogen::Base do
  subject { described_class.new }
  context '#set_repository' do
    let(:source)    { 'path' }
    let(:place)     { '/home/user/repository' }
    let(:repo_hash) { { repository: { source: source, place: place} } }
    let(:repo_args) { ["#{source}::#{place}"] }

    it 'save repository configuration' do
      expect(File).to receive(:directory?).and_return(true)
      expect(subject.configuration).to receive(:set).with(repo_hash)
      subject.set_repository(repo_args)
    end

    it 'raise error when repositor directory is missing' do
      expect(File).to receive(:directory?).and_return(false)
      expect { subject.set_repository(repo_args) }.to raise_error
    end

    context 'when source is unknown' do
      let(:source) { 'db' }
      it 'raise error' do
        expect { subject.set_repository(repo_args) }.to raise_error
      end
    end
  end

  it '#configuration' do
    expect(subject.configuration).to be_a Dogen::Configuration
  end

  context '#parse_opts' do
    let(:name)  { 'pawel niemczyk' }
    let(:email) { 'pniemczyk@o2.pl' }
    let(:args)  { ["name:#{name}", "email:#{email}"] }
    let(:opts)  { { 'name' => name, 'email' => email } }

    it 'return hash with options' do
      expect(subject.parse_opts(args)).to eq opts
    end
  end

  context '#read_opts_from_json' do
    it 'raise error when file missing' do
      expect(File).to receive(:exist?).and_return(false)
      expect{ subject.read_opts_from_json('test_file') }.to raise_error
    end

    let(:source_file) { '{"name":"pawel niemczyk", "email":"pniemczyk@o2.pl"}' }
    let(:hash)        { {'name' => 'pawel niemczyk', 'email' => 'pniemczyk@o2.pl'} }

    it 'return json' do
      expect(File).to receive(:exist?).and_return(true)
      expect(IO).to receive(:read).and_return(source_file)
      expect(subject.read_opts_from_json('test_file')).to eq hash
    end
  end

  context '#generate' do
    let(:pwd)      { '/home' }
    let(:path)     { 'txt/file.txt' }
    let(:new_path) { File.join(pwd, File.basename(path)) }
    let(:opts)     { { 'name' => 'pawel'} }
    let(:document) { double('document') }
    let(:source)   { 'User name is pawel %>' }
    let(:config)   { { repository: { place: 'some_path' } } }

    it 'generate file in current directory' do
      expect(Dir).to receive(:pwd).and_return(pwd)
      expect(subject.configuration).to receive(:get).and_return(config)
      expect(subject.send(:provider)).to receive(:get)
                                         .with(path, data: opts)
                                         .and_return(document)
      expect(document).to receive(:source).and_return(source)
      expect(File).to receive(:write).with(new_path, source)
      subject.generate(path, opts)
    end

  end
end

