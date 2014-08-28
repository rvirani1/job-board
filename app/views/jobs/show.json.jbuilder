json.(@job, :title, :description, :start_date, :end_date)
json.company @job.company.name
json.author do
  json.author_name @job.author.profile.first_name + " " + @job.author.profile.last_name
  json.author_email @job.author.email
end
