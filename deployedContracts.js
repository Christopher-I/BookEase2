import web3 from './web3';
import betContract from './build/BetContract.json';


export default(address) =>{
  return new web3.eth.Contract(
    JSON.parse(betContract.interface),
    address
  );
};
