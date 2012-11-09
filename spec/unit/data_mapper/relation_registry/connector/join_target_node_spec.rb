require 'spec_helper'

describe RelationRegistry::Connector, '#join_target_node' do
  subject { object.join_target_node }

  let(:object) { described_class.new(node, relationship, relations) }

  context 'for 1:1, 1:N or N:1 relationships' do
    let(:name)            { :users_X_addresses }
    let(:node)            { mock('relation_node', :name => name) }
    let(:relationship)    { mock_relationship(:addresses, :source_model => source_model, :target_model => target_model) }
    let(:source_model)    { mock_model(:User) }
    let(:target_model)    { mock_model(:Address) }
    let(:relations)       { mock('relations', :users => source_relation, :addresses => target_relation) }
    let(:source_relation) { mock('users_relation', :name => :users, :aliases => {}) }
    let(:target_relation) { mock('addresses_relation', :name => :addresses, :aliases => {}) }
    let(:source_mapper)   { mock_mapper(source_model, [], [ relationship ]) }
    let(:target_mapper)   { mock_mapper(target_model) }

    let(:expected_node) { mock('relation_node', :name => :addresses) }

    before do
      Mapper.mapper_registry << source_mapper << target_mapper

      relations.should_receive(:[]).with(:addresses).and_return(target_relation)
      relations.should_receive(:[]).with(expected_node.name).and_return(expected_node)
    end

    its(:name) { should be(:addresses) }
  end

  context 'for M:N relationships' do
    let(:name)             { :songs_X_song_tags_X_tags }
    let(:node)             { mock('relation_node', :name => name) }

    let(:via_relationship) { mock_relationship(:song_tags, :source_model => source_model, :target_model => via_model) }
    let(:relationship)     { mock_relationship(:tags,      :source_model => source_model, :target_model => target_model, :through => :song_tags) }

    let(:source_model)     { mock_model(:Song) }
    let(:via_model)        { mock_model(:SongTag) }
    let(:target_model)     { mock_model(:Tag) }

    let(:relations)        { mock('relations', :songs => source_relation, :song_tags => via_relation, :tags => target_relation) }

    let(:source_relation)  { mock('songs_relation',     :name => :songs,     :aliases => {}) }
    let(:via_relation)     { mock('song_tags_relation', :name => :song_tags, :aliases => {}) }
    let(:target_relation)  { mock('tags_relation',      :name => :tags,      :aliases => {}) }

    let(:source_mapper)    { mock_mapper(source_model, [], [ via_relationship, relationship ]) }
    let(:via_mapper)       { mock_mapper(via_model) }
    let(:target_mapper)    { mock_mapper(target_model) }

    let(:expected_node)    { mock('relation_node', :name => :song_tags_X_tags) }

    before do
      Mapper.mapper_registry << source_mapper << via_mapper << target_mapper

      relations.should_receive(:[]).with(expected_node.name).and_return(expected_node)
    end

    its(:name) { should be(expected_node.name) }
  end
end
