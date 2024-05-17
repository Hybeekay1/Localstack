variable "subscriber_name" {
  type = list(string)
  description = "list of of subscribers"
  default = [ "subscriber_one", "subscriber_two", "comsumer" ]
}


variable "queue_count" {
  type = number
  description = "queue count"
  default = 2
}