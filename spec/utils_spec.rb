require 'set'
Dir[File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', '*.rb'))].each {|f| require f }

FIXTURES_DIRECTORY = File.join(File.dirname(__FILE__), 'fixtures')

def write_fixture_file(path)
  allow_any_instance_of(Cryptme::Utils).to receive(:get_password).and_return('letmein')
  cryptme = Cryptme::Utils.new(path: path)
  cryptme.put(:foo, 'bar')
  cryptme.persist
  cryptme
end

def file_ext ; Cryptme::Utils::CRYPTME_FILE_EXT ; end

RSpec.describe Cryptme::Utils do 
  after(:each) do 
    Dir.foreach(FIXTURES_DIRECTORY) do |x| 
      x.include?(Cryptme::Utils::CRYPTME_FILE_EXT ) ? File.delete(File.join(FIXTURES_DIRECTORY, x)) : 'noop'
    end
  end

  describe '#initialize' do
    it 'should initialize new instance' do
      allow_any_instance_of(Cryptme::Utils).to receive(:get_password).and_return('letmein')
      path = File.join(FIXTURES_DIRECTORY, "newfile.#{file_ext}")
      cryptme = Cryptme::Utils.new(path: path)
      expect(cryptme.list).to eq []
      expect(cryptme).to_not receive(:unpack)
    end

    context 'path with wrong extension' do
      it 'should initialize new instance' do
        allow_any_instance_of(Cryptme::Utils).to receive(:get_password).and_return('letmein')
        path = File.join(FIXTURES_DIRECTORY, 'newfile.some_ext')
        cryptme = Cryptme::Utils.new(path: path)
        expect(File.file? path).to be(false) 
        expect(File.file? File.join(FIXTURES_DIRECTORY, "newfile.some_ext#{file_ext}")).to be(true)
      end
    end
  end
  
  describe '#unpack' do
    it 'should unpack a cryptme file' do 
      path = File.join(FIXTURES_DIRECTORY, "myfile#{file_ext}")
      cryptme = write_fixture_file(path)
      expect(File.file? path).to be(true)
      file_hash = cryptme.unpack(path)

      expect(file_hash[:secrets]).to_not be nil
      expect(file_hash[:nonce]).to_not be nil
    end
  end

  describe '#persist' do
    before(:each) do 
      Dir.foreach(FIXTURES_DIRECTORY) do |x| 
        x.include?(file_ext) ? File.delete(File.join(FIXTURES_DIRECTORY, x)) : 'noop'
      end
    end

    context 'file exists already' do
      it 'should write to .cryptme file' do
        path = File.join(FIXTURES_DIRECTORY, "myfile#{file_ext}")
        write_fixture_file(path)
        write_fixture_file(path)
        expect(File.file? path).to be(true)
      end
    end

    context 'writing a new file' do 
      it 'should write a .cryptme file' do
        path = File.join(FIXTURES_DIRECTORY, "myfile.#{file_ext}")
        write_fixture_file(path)
        expect(File.file? path).to be(true)
      end
    end
  end

  describe 'integration' do
    before(:all) do 
      Dir.foreach(FIXTURES_DIRECTORY) do |x| 
        x.include?(file_ext) ? File.delete(File.join(FIXTURES_DIRECTORY, x)) : 'noop'
      end
    end

    after(:all) do 
      Dir.foreach(FIXTURES_DIRECTORY) do |x| 
        x.include?(file_ext) ? File.delete(File.join(FIXTURES_DIRECTORY, x)) : 'noop'
      end
    end

    context 'existing cryptme; actual file IO' do
      it 'should read an encrypted file, update a value, and read again' do
        path = File.join(FIXTURES_DIRECTORY, "myfile#{file_ext}")
        password = 'letmein'
        write_fixture_file(path)

        cryptme = Cryptme::Utils.new(path: path)

        expect(cryptme.get('foo')).to eq 'bar'
        cryptme.put(:foo, 'baz')
        cryptme.persist

        cryptme = Cryptme::Utils.new(path: path)
        expect(cryptme.get('foo')).to eq 'baz'
        expect(cryptme.list.to_set).to eq Set['foo']
      end
    end

  end 

end
