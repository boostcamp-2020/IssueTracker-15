import jwt from './jwt'
import local from './local';

const passportConfig = () => {
  jwt();
  local();
}

export default passportConfig;