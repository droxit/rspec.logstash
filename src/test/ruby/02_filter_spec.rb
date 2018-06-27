# encoding: utf-8
require "logstash/devutils/rspec/spec_helper"

File.readlines("/logstash/test/logs/test.log").each do |line|
  message = "#{line}"
  # Load the configuration file
  @@configuration = String.new
  @@configuration << File.read("/logstash/test/pipeline/02_filter.conf")

  describe "Nginx filter" do

    config(@@configuration)

    sample("message" => message, "type" => "nginx") do
      # Check the ouput event/message properties
      insist { subject.get("type") } == "nginx"
      insist { subject.get("@timestamp").to_iso8601 } == "2016-09-05T20:06:17.000Z"
      insist { subject.get("verb") } == "GET"
      insist { subject.get("request") } == "/images/logos/hubpress.png"
      insist { subject.get("response") } == 200
      insist { subject.get("bytes") } == 5432
      reject { subject.get("tags").include?("_grokparsefailure") }
      reject { subject.get("tags").include?("_dateparsefailure") }
    end
  end
end
