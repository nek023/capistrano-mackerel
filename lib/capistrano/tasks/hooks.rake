require 'mackerel'

namespace :load do
  task :defaults do
    set :mackerel_annotate_tasks, ['deploy']
  end
end

namespace :mackerel do
  desc 'Set hooks'
  task :hooks do
    tasks = fetch(:mackerel_annotate_tasks).uniq
    tasks.each do |task|
      unless Rake::Task.task_defined?(task)
        abort "Error: Task '#{task}' is not defined."
      end

      task_name = task.tr(':', '_')

      before task, "mackerel:starting_#{task_name}" do
        results = fetch(:mackerel_measurements, {})
        results[task] = Time.now.to_i
        set :mackerel_measurements, results
      end

      after task, "mackerel:finished_#{task_name}" do
        finish_time = Time.now.to_i

        results = fetch(:mackerel_measurements)
        start_time = results[task]

        run_locally do
          info "Task '#{task}' took #{finish_time - start_time} sec."
        end

        client = Mackerel::Client.new(mackerel_api_key: fetch(:mackerel_api_key))
        client.post_graph_annotation({
          title: task,
          description: "Processing time for '#{task}'",
          from: start_time,
          to: finish_time,
          service: fetch(:mackerel_service),
          roles: fetch(:mackerel_roles)
        })
      end
    end
  end
end

Capistrano::DSL.stages.each do |stage|
  after stage, 'mackerel:hooks'
end
