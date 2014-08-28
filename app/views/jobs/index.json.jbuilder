json.array! @jobs do |job|
  # json.title         job.title
  # json.description   job.description
  # json.start_date    job.start_date
  # json.end_date      job.end_date
  json.(job, :title, :description, :start_date, :end_date)

  json.company       job.company.name
  json.author        job.author.email
  json.url           job_url(job, :json)

end
