# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'
require 'asciidoctor/doctest'
require 'asciidoctor/doctest/rake_tasks'

Rake::TestTask.new :test do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

RuboCop::RakeTask.new :lint do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.formatters = ['files']
  task.fail_on_error = false
end

DocTest::RakeTasks.new :doctest do |t|
  # Add extra input examples; if you don’t need that, you can omit this.
  t.input_examples :asciidoc, path: [
    *DocTest.examples_path,
    'test/examples/asciidoc',
  ]
  t.output_examples :html, path: 'test/examples/shiny'
  t.converter = DocTest::HTML::Converter
  t.converter_opts = {
    template_dirs: 'data/templates',
  }
end

task default: %w(lint test)
