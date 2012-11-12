class SongMapper < DataMapper::Mapper::Relation

  model         Song
  relation_name :songs
  repository    :postgres

  map :id,   Integer, :key => true
  map :name, String

  has 0..n, :song_tags, SongTag

  # ---------------------------------------------------------------
  # All join key definitions are the defaults that will be inferred
  # ---------------------------------------------------------------
  #
  # PROS
  #
  # * short and precise syntax
  # * should be quite familiar
  # * all use cases are covered
  #
  # CONTRAS
  #
  # * possibly otherwise useless relationships
  #   must be declared explicitly
  #
  # * operations on intermediaries can only be
  #   applied on the intermediary relationships
  #   (maybe not really a contra argument)
  #
  # * the join key scope for :via is not immediately
  #   obvious (it's the join from the intermediary
  #   to the target relation)
  #
  # * operation blocks can quickly look a bit weird
  #   (from a syntactic code alignment POV), especially
  #   when :via is a hash with more than one join key pair
  #   (composite key) which quickly leads to linebreaks
  #
  # ---------------------------------------------------------------

  # requires Song.relationships[:song_tags]
  # requires SongTag.relationships[:tag]
  has 0..n, :tags, Tag, :through => :song_tags

  # requires Song.relationships[:song_tags]
  # requires SongTag.relationships[:tag]
  # requires Tag.relationships[:infos]
  has 0..n, :infos, Info, :through => :tags

  # requires Song.relationships[:song_tags]
  # requires SongTag.relationships[:tag]
  # requires Tag.relationships[:infos]
  has 0..n, :tag_infos, Info, :through => :tags, :via => :infos

  # requires Song.relationships[:song_tags]
  has 0..n, :tags, Tag, :through => :song_tags, :via => {
    :tag_id  => :id
  }

  # requires Song.relationships[:tags]
  has 0..n, :infos, Info, :through => :tags, :via => {
    :id  => :tag_id
  }

  # ----------------------------------------------------------------
  # All relationship definitions below require no other relationship
  # ----------------------------------------------------------------
  #
  # PROS
  #
  # * no need to define otherwise possibly useless relationships
  #
  # CONTRAS
  #
  # * the relationship definition itself requires more
  #   details (join key information) in order to work
  #   around "missing" relationships
  #
  # ----------------------------------------------------------------

  # --------
  # OPTION 1
  # --------
  #
  # PROS
  #
  # * ???
  #
  # CONTRAS
  #
  # * too many hashes
  # * (not only) operation on target would look ugly (?) from a
  #   code alignment POV
  #
  has 0..n, :tags, Tag, :join => {
    :song_tags => {
      :on => {
        :id  => :song_id,
        :foo => :bar
      },
      :operation => lambda { }
    },
    :tags => {
      :on => {
        :tag_id => :id,
        :bam    => :baz
      },
      :operation => lambda { }
    }
  } do
    # code here
  end

  # --------
  # OPTION 2
  # --------
  #
  # PROS
  #
  # * reads kinda nice
  #
  # * might read better than the version below in case
  #   the join must be performed using composite keys
  #   (in that case, the hash passed to #via might lead
  #   to weird formatting)
  #
  # * operations on intermediaries are easily supported
  #
  # CONTRAS
  #
  # * requires a new Context object yielded by Mapper#via
  #
  # * requires Context#on and Context#operation to be able
  #   to Mapper#instance_eval correctly when building mapper
  #
  # * seems to be a bit verbose because of Context#on and
  #   especially Context#operation
  #
  has 0..n, :recent_good_tags, Tag do
    via songs => song_tags do
      on :id  => :song_id # keys are looked up in songs, values in song_tags
      operation do
        restrict { |r| r.song_tag_created_at.gte(Date.today - 7) }
      end
    end

    via song_tags => tags do
      on :tag_id => :id # keys are looked up in song_tags, values in tags
      operation do
        restrict { |r| r.tag_name.eq('good') }
      end
    end
  end

  # --------
  # OPTION 3
  # --------
  #
  # PROS
  #
  # * seems to be rather intuitive and slightly less verbose
  #   than the version above
  #
  # * might read worse than the version above in case
  #   the join must be performed using composite keys
  #   (in that case, the hash passed to #via might lead
  #   to weird formatting)
  #
  # * makes "disambiguating" join key relations very intuitive
  #
  # * requires only Mapper#via and no specific yield context object
  #   (the block simply gets instance_eval'ed in Mapper)
  #
  # CONTRAS
  #
  # * might lead to a bit weird formatting when joining on composite
  #   keys (either rather long lines, or block after linebreaks)
  #
  has 0..n, :recent_good_tags, Tag do
    via songs.id => song_tags.song_id do
      restrict { |r| r.song_tag_created_at.gte(Date.today - 7) }
    end

    via song_tags.tag_id => tags.id do
      restrict { |r| r.tag_name.eq('good') }
    end
  end

  # --------
  # OPTION 4
  # --------
  #
  # PROS
  #
  # * seems to be rather intuitive but slightly more verbose
  #   than the version above. Also, Mapper#joins would probably
  #   only be used in case of complex composite key definitions
  #
  # * might read worse than the version above in case
  #   the join must be performed using composite keys
  #   (in that case, the hash passed to #via might lead
  #   to weird formatting)
  #
  # * makes "disambiguating" join key relations very intuitive
  #
  # * requires only Mapper#via and no specific yield context object
  #   (the block simply gets instance_eval'ed in Mapper)
  #
  # * nice formatting of composite join key definitions
  #
  # CONTRAS
  #
  # * ???
  #
  has 0..n, :recent_good_tags, Tag do
    joins :song_tags, :on => {
      songs.id        => song_tags.song_id,
      songs.arbitrary => song_tags.other_key
    }

    via :song_tags do
      restrict { |r| r.song_tag_created_at.gte(Date.today - 7) }
    end

    via song_tags.tag_id => tags.id do
      restrict { |r| r.tag_name.eq('good') }
    end
  end

  # --------
  # OPTION 5
  # --------
  #
  # CONTRAS
  #
  # * requires a new Context object yielded by Mapper#via
  #
  # * requires Context#on and Context#operation to be able
  #   to Mapper#instance_eval correctly when building mapper
  #
  # * seems to be a bit verbose because of Context#on and
  #   especially Context#operation
  #
  has 0..n, :recent_good_tags, Tag do
    via song_tags do
      join songs.id => song_tags.song_id
      operation do
        restrict { |r| r.song_tag_created_at.gte(Date.today - 7) }
      end
    end

    via tags do
      join song_tags.tag_id => tags.id
      operation do
        restrict { |r| r.tag_name.eq('good') }
      end
    end
  end

  # ----------------------------------------------
  # Support accessing registered relations by name
  # ----------------------------------------------

  def respond_to?(name)
    super || !relations[name].nil?
  end

  private

  def method_missing(name, *args, &block)
    relation = relations[name]
    return relation if relation
    super
  end
end

class SongMapper < DataMapper::Mapper::Relation

  model         Song
  relation_name :songs
  repository    :postgres

  map :id,               Integer, :key => true
  map :name,             String
  map :recent_good_tags, Array[Tag]

  # Use (wrapped) veritas api directly
  #
  # PROS
  #
  # * most flexible
  #
  # CONTRAS
  #
  # * most verbose?
  #
  def recent_good_tags
    self.class.new(rename(:id => :song_id).join(song_tags).restrict { |r|
      r.song_tag_created_at.gte(Date.today - 7)
    }.join(tags.rename(:id => :tag_id)).restrict { |r|
      r.tag_name.eq('good')
    })
  end
end
