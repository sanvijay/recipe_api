# frozen_string_literal: true

module V1
  module Entities
    class User < Grape::Entity
      expose :id, expose_nil: false
      expose :first_name, documentation: { type: 'String', desc: 'User first name. Required.' },
                          expose_nil: false
      expose :last_name, documentation: { type: 'String', desc: 'User last name. Required.' },
                         expose_nil: false
      expose :email, documentation: { type: 'String', desc: 'User email. Required.' }, expose_nil: false
    end
  end
end
