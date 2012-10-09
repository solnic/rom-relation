require 'spec_helper_integration'

describe 'Relationship - Many To Many with generated mappers' do
  before(:all) do
    setup_db

    insert_song 1, 'foo'
    insert_song 2, 'bar'

    insert_tag 1, 'good'
    insert_tag 2, 'bad'

    insert_info 1, 1, "really good"
    insert_info 2, 2, "really bad"

    insert_song_tag 1, 1, 1
    insert_song_tag 2, 2, 2

    class Song
      attr_reader :id, :title, :tags, :infos

      def initialize(attributes)
        @id, @title, @tags, @infos = attributes.values_at(
          :id, :title, :tags, :infos
        )
      end
    end

    class Tag
      attr_reader :id, :name

      def initialize(attributes)
        @id, @name = attributes.values_at(:id, :name)
      end
    end

    class Info
      attr_reader :id, :text

      def initialize(attributes)
        @id, @text = attributes.values_at(:id, :text)
      end
    end

    class SongTag
      attr_reader :song_id, :tag_id

      def initialize(attributes)
        @song_id, @tag_id = attributes.values_at(:song_id, :tag_id)
      end
    end

    class TagMapper < DataMapper::Mapper::Relation::Base

      model         Tag
      relation_name :tags
      repository    :postgres

      map :id,   Integer, :key => true
      map :name, String
    end

    class InfoMapper < DataMapper::Mapper::Relation::Base

      model         Info
      relation_name :infos
      repository    :postgres

      map :id,     Integer, :key => true
      map :tag_id, Integer
      map :text,   String
    end

    class SongTagMapper < DataMapper::Mapper::Relation::Base

      model         SongTag
      relation_name :song_tags
      repository    :postgres

      map :song_id, Integer, :key => true
      map :tag_id,  Integer, :key => true
    end

    class SongMapper < DataMapper::Mapper::Relation::Base
      model         Song
      relation_name :songs
      repository    :postgres

      map :id,    Integer, :key => true
      map :title, String

      has 0..n, :song_tags, SongTag

      # TODO debug
      if RUBY_VERSION >= '1.9'

        has 0..n, :tags, Tag, :through => :song_tags

        has 0..n, :infos, Info, :through => :tags

      end
    end
  end

  it 'loads associated tag infos' do
    pending if RUBY_VERSION < '1.9'
    pending "ManyToMany through is not yet supported"

    mapper = DataMapper[Song].include(:infos)
    songs = mapper.to_a

    songs.should have(2).items

    song1, song2 = songs

    song1.title.should eql('foo')

    song1.infos.should have(1).item
    song1.infos.first.text.should eql('really good')

    song2.title.should eql('bar')
    song2.infos.should have(1).item
    song2.infos.first.text.should eql('really bad')
  end
end