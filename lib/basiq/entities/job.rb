# frozen_string_literal: true

module Basiq
  module Entities
    # Basiq::Entities::Job
    #
    #   Some of the services provided by Basiq are quite resource intensive,
    #   and may take a little time to process.
    #   To ensure that we provide a pleasant experience to you and
    #   your end-users, and that we avoid timeouts of long running connections
    #   to our server - we will handle these processes (jobs) asynchronously.
    #
    #   When an asynchronous operation is initiated (e.g. refreshing a connection)
    #   the Basiq server will create a job resource and return
    #   a status code of 202 - Accepted along with the job details (in the body).
    #   You can then query the job url to track its progress.
    #
    #
    #   Every step of the job has a status property that depicts its current state.
    #   The possible status values for each step are as follows:
    #
    #     1. pending      - The job has been created and is waiting to be started.
    #     2. in-progress  - The job has started and is currently processing.
    #     3. success      - The job has successfully completed.
    #     4. failed       - The job has failed.
    #
    #   Depending on the job being executed, some jobs will have multiple steps
    #   which need to be executed, for e.g. refreshing a
    #   connection requires the following steps to be completed:
    #
    #     1. Establish successful authentication with institution
    #     2. Fetch latest list of accounts
    #     3. Fetch latest list of transactions
    #
    #   You can keep track of the steps that have been completed by observing the
    #   results array property.
    #   As each step is successfully completed, its status will be
    #   updated and a result object with the link to the affected resource will be present.
    #   In the event that a step has failed, the result object will contain an embedded error object.
    #
    class Job < Base
      attr_accessor :id, :type, :links, :steps, :created, :updated, :self

      # @param [Hash] params
      #
      # @option params [String] :id -
      #   A string that uniquely identifies the job.
      #
      # @option params [String, DateTime] :created -
      #   The date time when the job was created.
      #
      # @option params [String, DateTime] :updated -
      #   The date time when the job was last updated.
      #
      # @option params [Array<Hash>] :steps -
      #   List of steps that need to be completed.
      #   With the following properties:
      #
      #     - title - Name of the step the job needs to complete.
      #     - status - Step status: pending, in-progress, success, failed.
      #     - result - List of URLs of the updated (or created) resources.
      #                Otherwise if a step failed contains an error response.
      #
      def initialize(params)
        super(params)
      end
    end
  end
end
