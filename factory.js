import web3 from './web3';
import ContractFactory from './build/SportsBetFactory.json';

const instance = new web3.eth.Contract(
  JSON.parse(ContractFactory.interface),
  '0x21aeAe8f0FA55f1D62C300E7667466d13Dd522C9'
);

export default instance;
