import web3 from './web3';
import betContract from './build/BetContract.json';
import deployedContracts from './deployedContracts';


export default async(address) =>{
  const betContract = deployedContracts(address);

  return await betContract.methods.getSummary().call();

};
