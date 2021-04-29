module TaskHelper
  def options_for_statuses_index
    options_for_statuses.unshift([i18n_t_model('.statuses.all'), 'all'])
  end

  def options_for_statuses
    Task.statuses.keys.map { |key|
      [i18n_t_model(".statuses.#{key}"), key]
    }
  end

  def options_for_sort
    [
      [i18n_t_model('.start_time_sort'), 'start_time'],
      [i18n_t_model('.end_time_sort'), 'end_time'],
      [i18n_t_model('.create_time_sort'), 'created_at']
    ] + options_for_priorities
  end

  def options_for_priorities
    Task.priorities.keys.map { |key|
      [i18n_t_model(".priorities.#{key}"), key]
    }
  end

  private
    def i18n_t_model(key)
      I18n.t("#{key}", scope: 'tasks.model')
    end
end
