variable alarm_type {
  type        = list(string) 
  description = "Different Alarm Types"
}

variable evaluation_periods{
  type        = list(string) 
  description = "Evaluation Periods"
}

variable metric_name {
  type        = list(string) 
  description = "Metric Name"
}   

variable name_space {
  type        = list(string) 
  description = "Name Space"
}

variable period {
  type        = list(string) 
  description = "Period"
}

variable statistic {
  type        = list(string) 
  description = "Statistic"
}

variable threshold {
  type        = list(string) 
  description = "Threshold"
}

# Define instance ids

variable instance_id {
  type        = list(string) 
  description = "ID of each instance"
}