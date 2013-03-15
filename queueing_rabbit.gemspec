# -*- encoding: utf-8 -*-
require File.expand_path('../lib/queueing_rabbit/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Artem Chistyakov"]
  gem.email         = ["chistyakov.artem@gmail.com"]
  gem.summary       = %q{QueueingRabbit is an AMQP-based queueing system}
  gem.homepage      = "https://github.com/temochka/queueing_rabbit"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "queueing_rabbit"
  gem.require_paths = ["lib"]
  gem.version       = QueueingRabbit::VERSION

  gem.extra_rdoc_files  = [ "LICENSE", "README.md" ]
  gem.rdoc_options      = ["--charset=UTF-8"]

  gem.add_dependency "amqp",  ">= 0.9.0"
  gem.add_dependency "bunny", ">= 0.9.0.pre7"

  gem.description   = <<description
    QueueingRabbit is a Ruby library providing convenient object-oriented syntax
    for managing background jobs using AMQP. All jobs' argumets are serialized
    to JSON and transfered to jobs using AMQP message payload. The library
    implements amqp and bunny gems as adapters making it possible to use
    synchronous publishing and asynchronous consuming, which might be useful for
    Rails app running on non-EventMachine based application servers (i. e.
    Passenger).

    Any Ruby class or Module can be transformed into QueueingRabbit's background
    job by including QueueingRabbit::Job module. It is also possible to inherit
    your class from QueueingRabbit::AbstractJob abstract class.

    The library is bundled with a Rake task which is capable of starting a
    worker processing a specified list of jobs.

    To achieve the required simplicity the gem doesn't try to support all
    features of AMQP protocol. It uses a restricted subset instead:

    * Only a single direct exchange is used
    * Every job is consumed using a separate channel
    * All jobs are consumed with acknowledgements
    * ACK is only sent to the broker if a job was processed successfully
    * Currently all messages are published with persistent option
description
end
