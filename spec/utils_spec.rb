require 'set'
Dir[File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', '*.rb'))].each {|f| require f }

FIXTURES_DIRECTORY = File.join(File.dirname(__FILE__), 'fixtures')

def write_fixture_file(path)
  allow_any_instance_of(Melon::Utils).to receive(:get_password).and_return('letmein')
  melon = Melon::Utils.new(path: path)
  melon.put(:foo, 'bar')
  melon.persist
  melon
end

RSpec.describe Melon::Utils do 
  after(:each) do 
    Dir.foreach(FIXTURES_DIRECTORY) do |x| 
      x.include?('.melon') ? File.delete(File.join(FIXTURES_DIRECTORY, x)) : 'noop'
    end
  end

  describe '#initialize' do
    it 'should initialize new instance' do
      allow_any_instance_of(Melon::Utils).to receive(:get_password).and_return('letmein')
      melon = Melon::Utils.new(path: 'newpath.txt')
      expect(melon.list).to eq []
      expect(melon).to_not receive(:unpack)
    end
  end
  

  describe '#unpack' do
    it 'should unpack a melon file' do 
      path = File.join(FIXTURES_DIRECTORY, 'myfile.melon')
      melon = write_fixture_file(path)
      expect(File.file? path).to be(true)
      file_hash = melon.unpack(path)

      expect(file_hash[:secrets]).to_not be nil
      expect(file_hash[:nonce]).to_not be nil
    end
  end

  describe '#persist' do
    before(:each) do 
      Dir.foreach(FIXTURES_DIRECTORY) do |x| 
        x.include?('.melon') ? File.delete(File.join(FIXTURES_DIRECTORY, x)) : 'noop'
      end
    end

    context 'file exists already' do
      it 'should write to .melon file' do
        path = File.join(FIXTURES_DIRECTORY, 'myfile.melon')
        write_fixture_file(path)
        write_fixture_file(path)
        expect(File.file? path).to be(true)
      end
    end

    context 'writing a new file' do 
      it 'should write a .melon file' do
        path = File.join(FIXTURES_DIRECTORY, 'myfile.melon')
        write_fixture_file(path)
        expect(File.file? path).to be(true)
      end
    end
  end

  describe 'integration' do
    before(:all) do 
      Dir.foreach(FIXTURES_DIRECTORY) do |x| 
        x.include?('.melon') ? File.delete(File.join(FIXTURES_DIRECTORY, x)) : 'noop'
      end
    end

    after(:all) do 
      Dir.foreach(FIXTURES_DIRECTORY) do |x| 
        x.include?('.melon') ? File.delete(File.join(FIXTURES_DIRECTORY, x)) : 'noop'
      end
    end

    context 'existing melon; actual file IO' do
      it 'should read an encrypted file, update a value, and read again' do
        path = File.join(FIXTURES_DIRECTORY, 'myfile.melon')
        password = 'letmein'
        write_fixture_file(path)

        melon = Melon::Utils.new(path: path)

        expect(melon.get('foo')).to eq 'bar'
        melon.put(:foo, 'baz')
        melon.persist

        melon = Melon::Utils.new(path: path)
        expect(melon.get('foo')).to eq 'baz'
        expect(melon.list.to_set).to eq Set['foo']
      end
    end

  end 

end
