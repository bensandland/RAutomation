require 'spec_helper'

include RAutomation::Adapter

describe MsUia::Spinner, if: SpecHelper.adapter == :ms_uia  do
  let(:main_window) { RAutomation::Window.new(title: 'MainFormWindow') }
  let(:data_entry) { main_window.button(value: 'Data Entry Form').click { window.exist? } }
  let(:window) { RAutomation::Window.new(title: 'DataEntryForm') }

  subject { window.spinner(id: 'numericUpDown1') }

  before(:each) do
    data_entry
  end

  it { should exist }

  it '#set' do
    subject.set 4.0
    expect(subject.value).to eq(4.0)
  end

  it '#minimum' do
     expect(subject.minimum).to eq(-100.0)
  end

  it '#maximum' do
     expect(subject.maximum).to eq(100.0)
  end

  it 'likes for values to be within range' do
    expect { subject.set(1000.0) }.to raise_error(RuntimeError)
  end

  it '#increment' do
    subject.set 5.0
    expect(subject.increment).to eq(6.0)
  end

  it '#decrement' do
    subject.set 5.0
    expect(subject.decrement).to eq(4.0)
  end
end
