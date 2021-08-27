//SPDX-License-Identifier: UNLICENSED
  pragma solidity ^0.8.0;

  import "@openzeppelin/contracts/metatx/ERC2771Context.sol";
  import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
  import "@openzeppelin/contracts/utils/Counters.sol";


  contract GaslessNFT is ERC2771Context, ERC721 {

    constructor(string memory name_, string memory symbol_, address forwarder_)
      ERC2771Context(forwarder_)
      ERC721(name_, symbol_) {
    }

     function _msgSender() internal view override(Context, ERC2771Context)
        returns (address sender) {
        sender = ERC2771Context._msgSender();
    }

    function _msgData() internal view override(Context, ERC2771Context)
        returns (bytes calldata) {
        return ERC2771Context._msgData();
    }
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    function awardItem(address player)
        public
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(player, newItemId);

        return newItemId;
    }
  }
