require_relative './config/environment'

use Rack::MethodOverride

use UserController
use PostController
use CountryController
use CommentController
run AppController
