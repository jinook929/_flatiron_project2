require_relative './config/environment'

use Rack::MethodOverride # <= this one on top of other controllers

use UserController
use PostController
use CountryController
use CommentController
run AppController
