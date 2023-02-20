// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CertificateToken is ERC721, Ownable {
using Counters for Counters.Counter;
Counters.Counter private _tokenIdCounter;

struct Certificate {
    string courseName;
    string studentName;
    uint256 yearOfCompletion;
    string instituteName;
}

mapping (uint256 => Certificate) private _certificates;

constructor() ERC721("CertificateToken", "CT") {}

function safeMint(address to, string memory courseName, string memory studentName, uint256 yearOfCompletion, string memory instituteName) public onlyOwner {
    uint256 tokenId = _tokenIdCounter.current();
    _tokenIdCounter.increment();
    _safeMint(to, tokenId);
    _certificates[tokenId] = Certificate(courseName, studentName, yearOfCompletion, instituteName);
}

function getCertificate(uint256 tokenId) public view returns (Certificate memory) {
    require(_exists(tokenId), "CertificateToken: certificate does not exist");
    return _certificates[tokenId];
}

function burn(uint256 tokenId) external {
    require(ownerOf(tokenId) == msg.sender, "CertificateToken: only the owner of the token can burn it");
    _burn(tokenId);
    delete _certificates[tokenId];
}

function _beforeTokenTransfer(address from, address to, uint256, uint256) pure override internal {
    require(from == address(0) || to == address(0), "CertificateToken: this is a Soulbound token. It cannot be transferred. It can only be burned by the token owner.");
}

function _burn(uint256 tokenId) internal override(ERC721) {
    super._burn(tokenId);
}
}